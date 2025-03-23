-- Webhook for instapic posts, recommended to be a public channel
INSTAPIC_WEBHOOK = "https://canary.discord.com/api/webhooks/"
-- Webhook for birdy posts, recommended to be a public channel
BIRDY_WEBHOOK = "https://canary.discord.com/api/webhooks/"

-- Discord webhook for server logs
LOGS = {
    Calls = "https://discord.com/api/webhooks/1311451411132977196/bHHi4AiqMXrjkiWKtMwU5-_iPRnFa_ibsIBslTOK4G3WuLTOWWTqawYMjiSgnL8o8Pew", -- set to false to disable
    Messages = "https://discord.com/api/webhooks/1311451468490080286/G_FeJm4ZWZ7CxoTOFCEtuMuZKM1LzIdtSK2dn502jKacgDNXB6CZVyBDcR6Zuhr4SXc9",
    InstaPic = "https://discord.com/api/webhooks/1311451518343450634/xw0YeGcSo85tRyRrGtQwuLcXsS7Dy8tBeNKG9WETUz26gmJtJJkEZZrn0BUZqKc4wiYO",
    Birdy = "https://discord.com/api/webhooks/1311451584286429226/bPxhUYgTcXTeWHFhUuSf4MS8pRSNk162lUs_3XRKzTXeug1ln6KKa5JDFPNkdGjtMjOj",
    YellowPages = "https://discord.com/api/webhooks/1311451638191620146/wIPdX9NADfpIMVqeCI5RlxY7fwuPVvKCdR0RVFVSlhcSW4LLyxeVTTa43dWdlpXDBNuB",
    Marketplace = "https://discord.com/api/webhooks/1311451690133622915/3yxvWvXl3jHpA9oswAdgpSktiVq_6HzslE3GK2yvSfdmhbeGacNy_NmGDPnwa12Fo18r",
    Mail = "https://discord.com/api/webhooks/1311451738980483153/j-07nly0gbKn_Zt41-qzGecP8KNZBvQiMnDZ0v0OmwD_N7-aKgtb-wnqCuY3yEP85r8i",
    Wallet = "https://discord.com/api/webhooks/1311451788175605770/M2ou7IsvGThvLZ3TMPX1naNe4tDGUZ9y8y8ANwDUFU1k-34GQw9iznPWE4k5Q2_fX8Nt",
    DarkChat = "https://discord.com/api/webhooks/1311451842655424532/jBtUEkAJ-QbItx2BRWx3liI_HCDp0fZ8XA3mjz8VtCJX1TBF0dMttwi0guuMh0n6xGq7",
    Services = "https://discord.com/api/webhooks/1311451898309509201/uAc1cRaiIu82fK2Auc7OupNFP_FMCXMJHz0ENLoy82B5Z2Oq4nNt5zqjiueaMvR1g25p",
    Crypto = "https://discord.com/api/webhooks/1311451951300608091/G5EMg0Y0WVY2Zjt7uu6lvih_xmYqFzaFQpvJtZYo7ZeR2fLkEx-htE4lL_6uyqZYnM-j",
    Trendy = "https://discord.com/api/webhooks/1311451999337844826/P5roZHmX16KV_FaXKbAHqDN1jk-6YIqxe9TXxvpaZWjD9d1s9gJ2etI5mXOA4Su22pvc",
    Uploads = "https://discord.com/api/webhooks/1311452056883822683/fs10gFTdItz3Zsh3MtT8DJ0JYOdJQB2uNRxa9WLmGknMbF_qgCkj2zY0BHAHSF-frAKh" -- all camera uploads will go here
}

-- Set your API keys for uploading media here.
-- Please note that the API key needs to match the correct upload method defined in Config.UploadMethod.
-- The default upload method is Fivemanage
-- We STRONGLY discourage using Discord as an upload method, as uploaded files may become inaccessible after a while.
-- You can get your API keys from https://fivemanage.com/
-- A video tutorial for how to set up Fivemanage can be found here: https://www.youtube.com/watch?v=y3bCaHS6Moc
API_KEYS = {
    Video = "RIj22c5KojPghInZIlnwHCBb29PvXhmd",
    Image = "RIj22c5KojPghInZIlnwHCBb29PvXhmd",
    Audio = "RIj22c5KojPghInZIlnwHCBb29PvXhmd",
}
