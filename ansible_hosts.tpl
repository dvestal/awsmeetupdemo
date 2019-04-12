[aws]
aws-web-1 ansible_host=${aws_address} ansible_user=ubuntu

[azure]
azure-web-1 ansible_host=${azure_address} ansible_user=ubuntu

[gcp]
gcp-web-1 ansible_host=${gcp_address} ansible_user=ubuntu

[linode]
linode-web-1 ansible_host=${linode_address} ansible_user=root

[digitalocean]
digitalocean-web-1 ansible_host=${do_address} ansible_user=root

;; Group Variables

[all:vars]
background_color=white

[aws:vars]
background_color=lightblue

[azure:vars]
background_color=darkblue

[gcp:vars]
background_color=orange

[linode:vars]
background_color=gray