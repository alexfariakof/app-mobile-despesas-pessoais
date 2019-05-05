import AsyncStorage from '@react-native-community/async-storage';

class ApiServices {

    state = {
        baseUrl: 'http://10.0.2.2:21379'
    }

    get = async (url, callBack) => {
        let response = null;
        const access = await AsyncStorage.getItem('@dpApiAccess');

        try {
            if (access) {
                const token = JSON.parse(access).accessToken;
                //alert(JSON.stringify(this.state.baseUrl + url + '      -   ' + token)); //return;
                
                if (typeof callBack !== 'function') {
                    response = await fetch(this.state.baseUrl + url, {
                        method: 'GET',
                        headers: {
                            Accept: 'application/json',
                            'Content-Type': 'application/json',
                            'Authorization': `Bearer ${token}`,
                        },
                    });

                    if (response.status === 200) {
                        let data = await response.json();
                        return data;
                    }
                    if (response.status === 401)
                        alert("{ 'message': 'Unauthorized' }");

                    if (response.status === 400)
                        alert("{ 'message': 'Bad Request' }");

                    if (response.status === 404)
                        alert("{ 'message': 'Not Found' }");
                }
                else {
                    
                    await fetch(this.state.baseUrl + url, {
                        method: 'GET',
                        headers: {
                            Accept: 'application/json',
                            'Content-Type': 'application/json',
                            'Authorization': `Bearer ${token}`,
                        },
                    }).then(response => response.json())
                        .then(json => callBack(json));
                }
            }
        }
        catch (error) {
            console.error(error);
        }
    }

    post = async (url, body, callBack) => {
        const access = await AsyncStorage.getItem('@dpApiAccess');

        try {
            if (access) {
                const token = JSON.parse(access).accessToken;
                //alert(JSON.stringify(this.state.baseUrl + url + '-' + JSON.stringify(body))); //return;
                await fetch(this.state.baseUrl + url, {
                    method: 'POST',
                    headers: {
                        Accept: 'application/json',
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${token}`,
                    }, body: JSON.stringify(body),
                }).then(response => response.json())
                    .then(json => callBack(json));
            }
            else {
                //alert(JSON.stringify(this.state.baseUrl + url + '-' + body)); return;
                await fetch(this.state.baseUrl + url, {
                    method: 'POST',
                    headers: {
                        Accept: 'application/json',
                        'Content-Type': 'application/json'
                    }, body: JSON.stringify(body),
                }).then(response => response.json())
                    .then(json => callBack(json));
            }
        }
        catch (error) {
            console.error(error);
        }
    }

    put = async (url, body) => {
        let response = null;
        const access = await AsyncStorage.getItem('@dpApiAccess');

        try {
            if (access) {
                const token = JSON.parse(access).accessToken;
                response = await fetch(this.state.baseUrl + url, {
                    method: 'PUT',
                    headers: {
                        Accept: 'application/json',
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${token}`,
                    }, body: JSON.stringify(body),
                }).then(response => response.json())
                    .then(json => callBack(json), callBack);
            }
        }
        catch (error) {
            console.error(error);
        }
    }

    delete = async (url, body) => {
        let response = null;
        const access = await AsyncStorage.getItem('@dpApiAccess');

        try {
            if (access) {
                const token = JSON.parse(access).accessToken;
                response = await fetch(this.state.baseUrl + url, {
                    method: 'DELETE',
                    headers: {
                        Accept: 'application/json',
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${token}`,
                    }, body: JSON.stringify(body),
                }).then(response => response.json())
                    .then(json => callBack(json), callBack);
            }
        }
        catch (error) {
            console.error(error);
        }
    }

    getException = (responseStatus) => {
        if (responseStatus === 200) {
            return JSON.parse({ message: 'Ok' });
        }
        if (responseStatus === 401)
            return JSON.parse({ 'message': 'Unauthorized' });

        if (responseStatus === 400)
            return JSON.parse({ 'message': 'Bad Request' });

        if (responseStatus === 404)
            return JSON.parse({ 'message': 'Not Found' });

    }
};

export default ApiServices;