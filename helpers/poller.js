// poller.js

function waitForElementToLoad(selector, timeout = 10000, interval = 500) {
    return new Promise((resolve, reject) => {
      const startTime = Date.now();
  
      const checkElement = () => {
        const element = document.querySelector(selector);
        if (element) {
          clearInterval(intervalId);
          resolve(element);
        } else if (Date.now() - startTime >= timeout) {
          clearInterval(intervalId);
          reject(new Error(`Element with selector '${selector}' not found within ${timeout}ms`));
        }
      };
  
      const intervalId = setInterval(checkElement, interval);
    });
  }
  