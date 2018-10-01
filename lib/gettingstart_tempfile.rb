# とりあえずチュートリアルとかサンプルの写経
require "tempfile"

Tempfile.open{|t|
    p t.path
    p File.exists?(t.path)
    t.write("heeelllllooooo tempfile!!!!!!!")
    # wirteはputsのエイリアスかと思いきやメタ文字は駄目っぽい
    t.write("\n")
    t.write("writing testttttttttt")

    # File.openでは読み込めない模様。
    File.open(t.path, "r") do |temp|
        temp.each_line.with_index do |line, idx|
            p "#{idx}: #{line}"
        end
    end

    # このやり方ならいける
    t.open.each_line.with_index do |line, idx|
        p "#{idx}: #{line}"
    end
}

# 変数定義
# newした場合は第一引数はプレフィクスになる。配列で指定した場合は第一要素はプレフィクス、第二要素はサフィックスになる
# openはnewのエイリアスっぽいやつだが、openを使うとブロックを渡せる
# -> createはopenに似ていますが、finalizerによるファイルの自動unlinkを行いません。（rubyドキュメント）
tempfile = Tempfile.new("tempfile")
p tempfile.path
tempfile.puts("here we goooooooo!!") 
tempfile.puts("\n")
tempfile.puts("wowowowoowowo")
# close処理が必要
tempfile.close

# closeしてもunlinkはされないのであとでopenして呼び出せる
tempfile.open.each_line.with_index do |line, idx|
    puts "#{idx}: #{line}"
end

# closeにtrueを渡すとGCやプログラム終了時を待たずにその場で破棄
tempfile.close(true)
# tempfile.open -> No such file or directory