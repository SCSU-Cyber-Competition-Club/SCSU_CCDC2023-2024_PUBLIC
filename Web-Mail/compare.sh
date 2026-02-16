list=(
"/etc/postfix/master.cf" 
"/etc/postfix/ad_virtual_mailbox_maps.cf"
)

for i in $list
do
   echo $i
   diff <(cat $i) <(cut -f2 /opt/bak$i)
done
