create or replace view aggView4130715546027938414 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin3540555864767165612 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4130715546027938414 where Comment_replyOf_Message.ParentMessageId=aggView4130715546027938414.v1;
create or replace view aggView1750239174696572992 as select v1, SUM(annot) as annot from aggJoin3540555864767165612 group by v1;
create or replace view aggJoin7181067004377441210 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1750239174696572992 where Message_hasCreator_Person.MessageId=aggView1750239174696572992.v1;
create or replace view aggView2989304616308950214 as select v1, SUM(annot) as annot from aggJoin7181067004377441210 group by v1;
create or replace view aggJoin5566644301329925108 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2989304616308950214 where Message_hasTag_Tag.MessageId=aggView2989304616308950214.v1;
select SUM(annot) as v9 from aggJoin5566644301329925108;
