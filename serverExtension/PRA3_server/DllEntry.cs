using RGiesecke.DllExport;
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;

namespace PRA3_server
{
	public class DllEntry
	{

		private static StringBuilder returnStringBuilder = new StringBuilder().Append("");
		private static Dictionary<string, Action> voidCallbacks = new Dictionary<string, Action>();
		private static Dictionary<string, Action<string>> dataCallbacks = new Dictionary<string, Action<string>>();


		static DllEntry()
		{
			DllEntry.voidCallbacks.Add("version", versionFuncion);
			DllEntry.dataCallbacks.Add("cleanupcode", DllEntry.cleanUpCodeForCompile);
		}

		[DllExport("_RVExtension@12", CallingConvention = System.Runtime.InteropServices.CallingConvention.Winapi)]
		public static void RVExtension(StringBuilder output, int outputSize, [MarshalAs(UnmanagedType.LPStr)] string input)
		{
			outputSize--;

			string[] inputParts = input.Split(new char[] { ':' }, 2);

			if (inputParts.Length == 2 && DllEntry.dataCallbacks.ContainsKey(inputParts[0]))
			{
				DllEntry.dataCallbacks[inputParts[0]](inputParts[1]);
			}
			else if (DllEntry.voidCallbacks.ContainsKey(inputParts[0]))
			{
				DllEntry.voidCallbacks[inputParts[0]]();
			}

			output.Append(returnStringBuilder);
		}

		public static void cleanUpCodeForCompile(string input)
		{
			do
			{
				input = input.Replace("  ", " ");
				input = input.Replace(Environment.NewLine + Environment.NewLine, Environment.NewLine);
			} while (input.Contains("  ") || input.Contains(Environment.NewLine + Environment.NewLine));
			returnStringBuilder.Append(input);

		}
		public static void versionFuncion()
		{
			returnStringBuilder.Append("0.1");
		}
		public static void removeAllDoubleSpaces(string input)
		{
			do
			{
				input = input.Replace("  ", " ");
			} while (input.Contains("  "));
			returnStringBuilder.Append(input);
		}

		public static void removeAllDoubleNewLines(string input)
		{
			do
			{
				input = input.Replace(Environment.NewLine + Environment.NewLine, Environment.NewLine);
			} while (input.Contains(Environment.NewLine + Environment.NewLine));
			returnStringBuilder.Append(input);
		}
	}
}