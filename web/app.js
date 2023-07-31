function getMessage() {
    return generateRandomProposal();
}

function getDialog(i) {
    return dialogs[i];
}

const generateRandomWord = (length) => {
  let result = '';
  const characters =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  for (let i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * characters.length));
  }
  return result;
};

const generateRandomProposal = () => {
    let result = '';
    const proposalLength = Math.floor(Math.random() * 30) + 5;
    for (let i = 0; i < proposalLength; i++) {
        let wordLength = Math.floor(Math.random() * 10) + 5;
        result += generateRandomWord(wordLength) + ' ';
    }
    return result.slice(0, -1);
}

const dialogs = [
                 {"messagesPerDay": [{"date": "2023-01-01T00:00:00.000Z", "messages": [{"text": "Сообщение от пользователя 0", "sendingDate": "2023-01-01T02:58:00.000Z", "isMine": false}, {"text": "Сообщение от пользователя 0 #2", "sendingDate": "2023-01-01T02:59:00.000Z", "isMine": false}]}, {"date": "2023-02-02T00:00:00.000Z", "messages": [{"text": "Сообщение от пользователя 0", "sendingDate": "2023-02-02T01:44:00.000Z", "isMine": false}, {"text": "Сообщение от пользователя 0 #2", "sendingDate": "2023-02-02T03:58:00.000Z", "isMine": false}]}]},
                 {"messagesPerDay": [{"date": "2023-01-01T00:00:00.000Z", "messages": [{"text": "Сообщение от пользователя 1", "sendingDate": "2023-01-01T02:58:00.000Z", "isMine": false}, {"text": "Сообщение от пользователя 1 #2", "sendingDate": "2023-01-01T12:23:00.000Z", "isMine": false}]}, {"date": "2023-02-02T00:00:00.000Z", "messages": [{"text": "Сообщение от пользователя 1", "sendingDate": "2023-02-02T02:58:00.000Z", "isMine": false}, {"text": "Сообщение от пользователя 1 #2", "sendingDate": "2023-02-02T12:23:00.000Z", "isMine": false}]}]}
                ]