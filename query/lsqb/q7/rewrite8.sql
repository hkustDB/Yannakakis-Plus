create or replace view aggView2127836123279812549 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin4730771459318113143 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView2127836123279812549 where Message_hasCreator_Person.MessageId=aggView2127836123279812549.v1;
create or replace view aggView1103435977584432789 as select v1, SUM(annot) as annot from aggJoin4730771459318113143 group by v1;
create or replace view aggJoin4424342108968711101 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView1103435977584432789 where Message_hasTag_Tag.MessageId=aggView1103435977584432789.v1;
create or replace view aggView4935052065034484484 as select v1, SUM(annot) as annot from aggJoin4424342108968711101 group by v1;
create or replace view aggJoin382019671598822332 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4935052065034484484 where Comment_replyOf_Message.ParentMessageId=aggView4935052065034484484.v1;
select SUM(annot) as v9 from aggJoin382019671598822332;
