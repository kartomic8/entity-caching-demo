fn supergraph_service(service) {
  let request_callback = |request| {
    if "x-user-id" in request.headers {
      let user_id = request.headers["x-user-id"];

      if user_id != () {
        request.context["user_id"] = user_id;
        print(`SETTING request.context[user_id] to ${user_id}`);
      }
    }
  };

  service.map_request(request_callback);
}
