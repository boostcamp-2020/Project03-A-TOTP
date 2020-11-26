import axios from 'axios';

const confirmEmailAPI = (query: string): void => {
  try {
    axios.get(`/api/user/confirm-email?user=${query}`);
  } catch (e) {
    /**
     * @TODO 처리 필요
     */
  }
};

export { confirmEmailAPI };
