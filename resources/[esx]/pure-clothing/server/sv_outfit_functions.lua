function generateJobOutfits(source, job, rank)
    local model = GetEntityModel(GetPlayerPed(source))
    local response = MySQL.query.await('SELECT* FROM `clothing_job_outfits` WHERE jobName = ? AND minRank <= ? AND modelHash = ?', {
        job, rank, model
    })
     
    local outfits = {}

    if response then
        for i = 1, #response do
            local row = response[i]
            outfits[#outfits + 1] = {
                name = row.name,
                outfit = json.decode(row.outfit),
                uniqueOutfitid = row.id
            }
        end
    end
    return outfits
end