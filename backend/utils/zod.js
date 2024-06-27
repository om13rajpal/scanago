const zod = require("zod");

function validateInput(data) {
  const schema = zod.object({
    email: zod.string().email(),
    password: zod.string().min(6),
  });

  const response = schema.safeParse(data);
  return response;
}

module.exports = {
  validateInput,
};
