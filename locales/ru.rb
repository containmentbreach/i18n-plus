{
  :ru => {
    :pluralization => proc do |entry, n|
      key = n==0 ? :zero : n%10==1 && n%100!=11 ? :one : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? :few : :other
      key = :other unless entry.has_key?(key)
      entry.fetch(key) { raise InvalidPluralizationData.new(entry, n) }
    end
  }
}
