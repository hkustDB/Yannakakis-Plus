create or replace view aggView6989524704045044066 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin5076320635847722866 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6989524704045044066 where Comment_replyOf_Message.ParentMessageId=aggView6989524704045044066.v1;
create or replace view aggView1286351861635685864 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin4712229208846153568 as select v1, aggJoin5076320635847722866.annot * aggView1286351861635685864.annot as annot from aggJoin5076320635847722866 join aggView1286351861635685864 using(v1);
create or replace view aggView1965621465647985162 as select v1, SUM(annot) as annot from aggJoin4712229208846153568 group by v1;
create or replace view aggJoin1247317713617229670 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView1965621465647985162 where Message_hasTag_Tag.MessageId=aggView1965621465647985162.v1;
select SUM(annot) as v9 from aggJoin1247317713617229670;
