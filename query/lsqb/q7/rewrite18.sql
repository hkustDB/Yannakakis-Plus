create or replace view aggView6376308814074728612 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin994304639285650151 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6376308814074728612 where Message_hasTag_Tag.MessageId=aggView6376308814074728612.v1;
create or replace view aggView4027269767603741493 as select v1, SUM(annot) as annot from aggJoin994304639285650151 group by v1;
create or replace view aggJoin6595445258490796886 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4027269767603741493 where Comment_replyOf_Message.ParentMessageId=aggView4027269767603741493.v1;
create or replace view aggView1396221432476732934 as select v1, SUM(annot) as annot from aggJoin6595445258490796886 group by v1;
create or replace view aggJoin557586510026872949 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1396221432476732934 where Message_hasCreator_Person.MessageId=aggView1396221432476732934.v1;
select SUM(annot) as v9 from aggJoin557586510026872949;
