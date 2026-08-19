const { after, afterEach, before, describe, test } = require('node:test');
const fs = require('node:fs');
const path = require('node:path');

const {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} = require('@firebase/rules-unit-testing');
const {
  collection,
  doc,
  getDoc,
  getDocs,
  query,
  serverTimestamp,
  setDoc,
  updateDoc,
} = require('firebase/firestore');

const projectId = 'demo-scout-app';
let testEnv;

function userData(uid, accountType = null) {
  return {
    uid,
    email: `${uid}@example.test`,
    displayName: uid,
    photoUrl: null,
    accountType,
    onboardingCompleted: accountType !== null,
    status: 'active',
    createdAt: serverTimestamp(),
    updatedAt: serverTimestamp(),
  };
}

function playerData(uid) {
  return {
    userId: uid,
    fullName: `Player ${uid}`,
    birthDate: new Date('2000-01-01T00:00:00.000Z'),
    position: 'midfielder',
    preferredFoot: 'right',
    currentClub: null,
    bio: null,
    createdAt: serverTimestamp(),
    updatedAt: serverTimestamp(),
  };
}

async function seedUser(uid, accountType) {
  await testEnv.withSecurityRulesDisabled(async (context) => {
    await setDoc(doc(context.firestore(), 'users', uid), {
      ...userData(uid, accountType),
      createdAt: new Date('2026-01-01T00:00:00.000Z'),
      updatedAt: new Date('2026-01-01T00:00:00.000Z'),
    });
  });
}

async function seedPlayer(uid) {
  await testEnv.withSecurityRulesDisabled(async (context) => {
    await setDoc(doc(context.firestore(), 'players', uid), {
      ...playerData(uid),
      createdAt: new Date('2026-01-01T00:00:00.000Z'),
      updatedAt: new Date('2026-01-01T00:00:00.000Z'),
    });
  });
}

before(async () => {
  testEnv = await initializeTestEnvironment({
    projectId,
    firestore: {
      rules: fs.readFileSync(
        path.resolve(__dirname, '../../firestore.rules'),
        'utf8',
      ),
    },
  });
});

afterEach(async () => {
  await testEnv.clearFirestore();
});

after(async () => {
  await testEnv.cleanup();
});

describe('users/{uid}', () => {
  test('owner reads own user', async () => {
    await seedUser('playerA', 'player');
    const db = testEnv.authenticatedContext('playerA').firestore();
    await assertSucceeds(getDoc(doc(db, 'users', 'playerA')));
  });

  test('another user cannot read a private user', async () => {
    await seedUser('playerA', 'player');
    const db = testEnv.authenticatedContext('playerB').firestore();
    await assertFails(getDoc(doc(db, 'users', 'playerA')));
  });

  test('owner creates the initial constrained user document', async () => {
    const db = testEnv.authenticatedContext('newUser').firestore();
    await assertSucceeds(
      setDoc(doc(db, 'users', 'newUser'), userData('newUser')),
    );
  });

  test('owner selects an account type only when it was previously null', async () => {
    await seedUser('newUser', null);
    const db = testEnv.authenticatedContext('newUser').firestore();
    await assertSucceeds(updateDoc(doc(db, 'users', 'newUser'), {
      accountType: 'player',
      onboardingCompleted: true,
      updatedAt: serverTimestamp(),
    }));
  });

  test('user cannot change protected fields', async () => {
    await seedUser('playerA', 'player');
    const db = testEnv.authenticatedContext('playerA').firestore();

    await assertFails(updateDoc(doc(db, 'users', 'playerA'), {
      accountType: 'scout', updatedAt: serverTimestamp(),
    }));
    await assertFails(updateDoc(doc(db, 'users', 'playerA'), {
      status: 'blocked', updatedAt: serverTimestamp(),
    }));
    await assertFails(updateDoc(doc(db, 'users', 'playerA'), {
      createdAt: serverTimestamp(), updatedAt: serverTimestamp(),
    }));
    await assertFails(updateDoc(doc(db, 'users', 'playerA'), {
      unexpectedAdminFlag: true, updatedAt: serverTimestamp(),
    }));
  });
});

describe('players/{uid}', () => {
  test('Player creates own profile', async () => {
    await seedUser('playerA', 'player');
    const db = testEnv.authenticatedContext('playerA').firestore();
    await assertSucceeds(
      setDoc(doc(db, 'players', 'playerA'), playerData('playerA')),
    );
  });

  test('Player cannot create a profile for another UID', async () => {
    await seedUser('playerA', 'player');
    const db = testEnv.authenticatedContext('playerA').firestore();
    await assertFails(
      setDoc(doc(db, 'players', 'playerB'), playerData('playerB')),
    );
  });

  test('Player reads own profile but cannot read or list other players', async () => {
    await seedUser('playerA', 'player');
    await seedPlayer('playerA');
    await seedPlayer('playerB');
    const db = testEnv.authenticatedContext('playerA').firestore();

    await assertSucceeds(getDoc(doc(db, 'players', 'playerA')));
    await assertFails(getDoc(doc(db, 'players', 'playerB')));
    await assertFails(getDocs(query(collection(db, 'players'))));
  });

  test('Player updates own profile', async () => {
    await seedUser('playerA', 'player');
    await seedPlayer('playerA');
    const db = testEnv.authenticatedContext('playerA').firestore();
    await assertSucceeds(updateDoc(doc(db, 'players', 'playerA'), {
      bio: 'Updated by its owner', updatedAt: serverTimestamp(),
    }));
  });

  test('Player cannot update another Player', async () => {
    await seedUser('playerA', 'player');
    await seedPlayer('playerB');
    const db = testEnv.authenticatedContext('playerA').firestore();
    await assertFails(updateDoc(doc(db, 'players', 'playerB'), {
      bio: 'Tampered', updatedAt: serverTimestamp(),
    }));
  });

  test('Scout reads and lists players', async () => {
    await seedUser('scoutA', 'scout');
    await seedPlayer('playerA');
    const db = testEnv.authenticatedContext('scoutA').firestore();
    await assertSucceeds(getDoc(doc(db, 'players', 'playerA')));
    await assertSucceeds(getDocs(query(collection(db, 'players'))));
  });

  test('unauthenticated client cannot read players', async () => {
    await seedPlayer('playerA');
    const db = testEnv.unauthenticatedContext().firestore();
    await assertFails(getDoc(doc(db, 'players', 'playerA')));
    await assertFails(getDocs(query(collection(db, 'players'))));
  });

  test('Scout cannot alter a Player', async () => {
    await seedUser('scoutA', 'scout');
    await seedPlayer('playerA');
    const db = testEnv.authenticatedContext('scoutA').firestore();
    await assertFails(updateDoc(doc(db, 'players', 'playerA'), {
      bio: 'Tampered by scout', updatedAt: serverTimestamp(),
    }));
  });
});
