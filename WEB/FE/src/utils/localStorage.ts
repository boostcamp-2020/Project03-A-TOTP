const STORAGE_KEY = '_ddis_user';

const storageHandler = {
  set(userName: string): void {
    localStorage.setItem(STORAGE_KEY, userName);
  },

  get(): string | null {
    return localStorage.getItem(STORAGE_KEY);
  },

  clear(): void {
    localStorage.clear();
  },
};

export default storageHandler;
