using RGiesecke.DllExport;
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.RegularExpressions;

namespace PRA3_server
{
	public class DllEntry
	{

		private static StringBuilder returnStringBuilder = new StringBuilder().Append("");
		private static Dictionary<string, Action> voidCallbacks = new Dictionary<string, Action>();
		private static Dictionary<string, Action<string>> dataCallbacks = new Dictionary<string, Action<string>>();
		private static Dictionary<string, RegexOptions> regexOptions = new Dictionary<string, RegexOptions>();
		// regex Pattern
		private static string pattern = "";
		private static RegexOptions rgxOpt = RegexOptions.None;
		static DllEntry()
		{
			DllEntry.voidCallbacks.Add("version", versionFuncion);
			DllEntry.dataCallbacks.Add("cleanupcode", DllEntry.cleanUpCodeForCompile);

			/* Regex SQF Example
			 *
			 * "registerRegex:Compiled:\b(\w+)\s\1\b"
			 *
			 * Known RegexOptions
			 * - Compiled
			 * - CultureInvariant
			 * - ECMAScript
			 * - ExplicitCapture
			 * - IgnoreCase
			 * - IgnorePatternWhitespace
			 * - Multiline
			 * - RightToLeft
			 * - Singleline
			 * - if not known then None is used
			 *
			 */
			DllEntry.dataCallbacks.Add("registerRegex", DllEntry.regexRegister);
			DllEntry.dataCallbacks.Add("replaceRegex", DllEntry.regexReplace);
			//DllEntry.dataCallbacks.Add("matchRegex", DllEntry.regexMatch);
			//DllEntry.dataCallbacks.Add("splitRegex", DllEntry.regexSplit);

			// register Regex Options
			DllEntry.regexOptions.Add("Compiled", RegexOptions.Compiled);
			DllEntry.regexOptions.Add("CultureInvariant", RegexOptions.CultureInvariant);
			DllEntry.regexOptions.Add("ECMAScript", RegexOptions.ECMAScript);
			DllEntry.regexOptions.Add("ExplicitCapture", RegexOptions.ExplicitCapture);
			DllEntry.regexOptions.Add("IgnoreCase", RegexOptions.IgnoreCase);
			DllEntry.regexOptions.Add("IgnorePatternWhitespace", RegexOptions.IgnorePatternWhitespace);
			DllEntry.regexOptions.Add("Multiline", RegexOptions.Multiline);
			DllEntry.regexOptions.Add("RightToLeft", RegexOptions.RightToLeft);
			DllEntry.regexOptions.Add("Singleline", RegexOptions.Singleline);

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

			output.Append(returnStringBuilder.ToString());
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

		public static void regexRegister(string input)
		{
			string[] inputs = input.Split(new char[] { ':' }, 2);
			if (DllEntry.regexOptions.ContainsKey(inputs[0]))
			{
				rgxOpt = DllEntry.regexOptions[inputs[0]];
			}
			else
			{
				rgxOpt = RegexOptions.None;
			}
			pattern = @"" + input;
		}

		public static void regexReplace(string input)
		{
			Regex rgx = new Regex(pattern, rgxOpt);
			input = rgx.Replace(input, pattern);
			returnStringBuilder.Append(input);
		}

	}
}