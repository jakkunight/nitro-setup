_: {
  # Blocky adblocker service:
  services.blocky = {
    enable = true;
    settings = {
      ports.dns = 53; # Port for incoming DNS Queries.
      upstreams.groups.default = [
        "https://one.one.one.one/dns-query" # Using Cloudflare's DNS over HTTPS server for resolving queries.
      ];
      # For initially solving DoH/DoT Requests when no system Resolver is available.
      bootstrapDns = {
        upstream = "https://one.one.one.one/dns-query";
        ips = ["1.1.1.1" "1.0.0.1"];
      };
      #Enable Blocking of certain domains.
      blocking = {
        denylists = {
          #Adblocking
          ads = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/adaway.org/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/adblock-nocoin-list/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/adguard-simplified/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/awavenue-ads/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/d3host/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/dandelionsprout-nordic/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-ara/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-bul/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-ces-slk/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-deu/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-fra/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-heb/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-ind/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-ita/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-kor/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-lav/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-lit/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-nld/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-pol/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-por/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-rus/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-spa/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easylist-zho/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/easyprivacy/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/eth-phishing-detect/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/gfrogeye-firstparty-trackers/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/hostsvn/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/kadhosts/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/matomo.org-spammers/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/mitchellkrogza-badd-boyz-hosts/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/pgl.yoyo.org/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/phishing.army/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/red.flag.domains/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/someonewhocares.org/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/spam404.com/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/stevenblack/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/turkish-ad-hosts/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-2020/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-2021/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-2022/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-2023/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-2024/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-2025/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-abuse/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-badware/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/ublock-privacy/list.txt"
            "https://raw.githubusercontent.com/hectorm/hmirror/master/data/urlhaus/list.txt"
          ];
          #Another filter for blocking adult sites
          adult = ["https://blocklistproject.github.io/Lists/porn.txt"];
          #You can add additional categories
        };
        #Configure what block categories are used
        clientGroupsBlock = {
          default = ["ads"];
          # kids-ipad = ["ads" "adult"];
        };
      };
    };
  };
}
