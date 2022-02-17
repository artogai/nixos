protocol: port: ca: cert: key: crl: tlsCrypt: ''
  proto ${protocol}
  ${if (protocol == "tcp") then "socket-flags TCP_NODELAY" else ""}
  port ${toString port}
  dev tun

  ca ${ca}
  cert ${cert}
  key ${key}

  dh none #don't use key exchanges with static parameters
  ${if (protocol == "tcp") then  "server 10.8.0.0 255.255.255.0" else "server 10.9.0.0 255.255.255.0"} # use 10.8.0.0/24 for clients

  float # allow clients to roam
  keepalive 10 60 #send keepalive pings every 10 seconds, disconnect clients after 60 seconds of no traffic
  opt-verify #reject clients with mismatched settings

  user nobody
  group nobody

  topology subnet

  push "redirect-gateway def1 bypass-dhcp"

  persist-key #keep the key in memory, don't reread it from disk
  persist-tun #keep the virtual network device open between restarts

  tls-version-min 1.2

  #data channel cipher
  cipher AES-128-GCM

  # TLS 1.3 encryption settings
  tls-ciphersuites TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256
  # TLS 1.2 encryption settings
  tls-cipher TLS-ECDHE-ECDSA-WITH-CHACHA20-POLY1305-SHA256:TLS-ECDHE-RSA-WITH-CHACHA20-POLY1305-SHA256:TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256:TLS-ECDHE-RSA-WITH-AES-128-GCM-SHA256

  dh none #disable static Diffie-Hellman parameters since we're using ECDHE
  ecdh-curve secp384r1

  tls-server #be the server side of the TLS handshake
  crl-verify ${crl}

  remote-cert-tls client #require client certificates to have the correct extended key usage
  verify-client-cert require #reject connections without certificates
  tls-cert-profile preferred #require certificates to use modern key sizes and signatures

  tls-crypt ${tlsCrypt}
''
