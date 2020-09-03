using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Numerics;

namespace CTF
{

    class Program
    {
        static void Main(string[] args)
        {
            var guess = StringToByteArray(args[3]);
            if(guess.Length != 16)
            {
                Console.WriteLine("Wrong length biatch");
                return;
            }

            using var client = new TcpClient();
            client.NoDelay = true;
            //client.Connect("tracing.2020.ctfcompetition.com", 1337);
            client.Connect(args[0], int.Parse(args[1]));

            using var stream = client.GetStream();

            // Skriv först vår gissning
            stream.Write(guess);

            for (int i = 0; i < int.Parse(args[2]); i++)
            {
                // Första halvan:  4354467b31426628
                if (guess[15] == 0xff)
                {
                    guess[15] = 0;
                    guess[14]++;
                } else
                {
                    guess[15]++;
                }
                stream.Write(guess);
            }

            stream.Flush();
            var ms = Stopwatch.StartNew();
                stream.Close();
            while (client.Connected) { }
            ms.Stop();
            Console.WriteLine("ms = {0}", ms.ElapsedMilliseconds);

            client.Close();
        }

        public static byte[] StringToByteArray(string hex)
        {
            return Enumerable.Range(0, hex.Length)
                             .Where(x => x % 2 == 0)
                             .Select(x => Convert.ToByte(hex.Substring(x, 2), 16))
                             .ToArray();
        }
    }
}

