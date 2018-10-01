## Tempfile
一時ファイルを作ってくれるやつ。名前から期待される通りの振る舞いをする。自動でGCされたりとか。
```ruby
require "tempfile"
```

### Fileへの書き込みはputsを使う
これTempfileの話じゃなくてFileだけど。

書き込みは`write`および`puts`でできるけど、`write`だとメタ文字ができないっぽい？ので注意

## ブロックで使う
ふつうのFile.openと同じように、ブロックを抜けたら自動でcloseされる
```ruby
Tempfile.open{|t|
    p t.path
end
```
### 読み込みは Tempfile.openで
File.openでは読み込めない模様。
```ruby
File.open(t.path, "r") do |temp|
    temp.each_line.with_index do |line, idx|
        # 読み込めない
    end
end
```
（ただ、たぶんopenしたときの`mode`とか`options`でなんとかできるんじゃないかな。ファイルの権限とか。知らんけど）

Tempfile.openを使うと楽。
```ruby
t.open.each_line.with_index do |line, idx|
    p "#{idx}: #{line}"
end
```

## 変数に代入
```ruby
tempfile = Tempfile.new("tempfile")
```
`new`あるいは`open`または`create`で指定する。  
ただし`create`は自動でunlinkしなかったり、`open`だとブロックを渡せたり、など挙動に違いがある


## 参考
[class Tempfile](https://docs.ruby-lang.org/ja/latest/class/Tempfile.html)  
[一時ディレクトリ/一時ファイルを使用する](https://maku77.github.io/ruby/temporary-file.html)  
[一時ファイルを作成する](http://rubytips86.hatenablog.com/entry/2014/03/23/193153)
