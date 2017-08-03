let socket = new Phoenix.Socket("/socket", {params: {token: window.userToken}})

socket.connect()

let channel = socket.channel("table:test", {})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("err", resp => { console.log("Failed to join", resp) })

channel.on("user_id", payload => { console.log(payload) })
