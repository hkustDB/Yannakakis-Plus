create or replace view aggView5651419794247820818 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin3644041853088644700 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView5651419794247820818 where Message_hasTag_Tag.MessageId=aggView5651419794247820818.v1;
create or replace view aggView4446541962542717022 as select v1, SUM(annot) as annot from aggJoin3644041853088644700 group by v1;
create or replace view aggJoin9148730018031676122 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4446541962542717022 where Comment_replyOf_Message.ParentMessageId=aggView4446541962542717022.v1;
create or replace view aggView3730874043601979372 as select v1, SUM(annot) as annot from aggJoin9148730018031676122 group by v1;
create or replace view aggJoin5893945263779285837 as select annot from Person_likes_Message as Person_likes_Message, aggView3730874043601979372 where Person_likes_Message.MessageId=aggView3730874043601979372.v1;
select SUM(annot) as v9 from aggJoin5893945263779285837;
