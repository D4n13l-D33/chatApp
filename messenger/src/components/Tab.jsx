import { Box, Button, Dialog, Flex, Tabs, Text, TextField } from "@radix-ui/themes"
import { useState } from "react"
import UseRegisterHook from "../hooks/UseRegisterHook";
import Register from "./Register";

const Tab = () => {
    const [uName, setName] = useState("");
    const handleRegister = UseRegisterHook(uName);
  return (
    <Tabs.Root defaultValue="account">
  <Tabs.List>
    <Tabs.Trigger value="account">Name Service</Tabs.Trigger>
    <Tabs.Trigger value="chat">Chat Section</Tabs.Trigger>
  </Tabs.List>

  <Box pt="3">
    <Tabs.Content value="account">
    <Dialog.Root>
        <Dialog.Trigger>
            <Button>Create ENS</Button>
        </Dialog.Trigger>

        <Dialog.Content maxWidth="450px">
            <Dialog.Title>Create ENS</Dialog.Title>
            <Dialog.Description size="2" mb="4">
            Create Your unique Name
            </Dialog.Description>

            <Flex direction="column" gap="3">
            <label>
                <Text as="div" size="2" mb="1" weight="bold">
                Name
                </Text>
                <TextField.Root
                value={uName}
                onChange={(e) => setName(e.target.value)}
                placeholder="Enter a Unique Name"
                />
            </label>
            </Flex>

            <Flex gap="3" mt="4" justify="end">
            <Dialog.Close>
                <Button variant="soft" color="gray">
                Cancel
                </Button>
            </Dialog.Close>
            <Dialog.Close>
                <Button onClick={handleRegister}>Submit</Button>
            </Dialog.Close>
            </Flex>
        </Dialog.Content>
    </Dialog.Root>
    </Tabs.Content>

    <Tabs.Content value="chat">
      <Register />
    </Tabs.Content>
  </Box>
</Tabs.Root>
  )
}

export default Tab