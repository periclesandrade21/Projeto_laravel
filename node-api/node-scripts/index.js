import fetch from 'node-fetch';

async function consultarNotas() {
  const res = await fetch('http://app/health');
  const data = await res.text();
  console.log('Health Laravel:', data);
}

consultarNotas().catch(console.error);
