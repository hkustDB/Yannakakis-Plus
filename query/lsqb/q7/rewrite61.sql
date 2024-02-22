create or replace view aggView6119358619448437269 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin1983153341424379259 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6119358619448437269 where Message_hasTag_Tag.MessageId=aggView6119358619448437269.v1;
create or replace view aggView6953109026211062198 as select v1, SUM(annot) as annot from aggJoin1983153341424379259 group by v1;
create or replace view aggJoin5158264889626886027 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6953109026211062198 where Message_hasCreator_Person.MessageId=aggView6953109026211062198.v1;
create or replace view aggView2097067683924502974 as select v1, SUM(annot) as annot from aggJoin5158264889626886027 group by v1;
create or replace view aggJoin1240557801234773925 as select annot from Person_likes_Message as Person_likes_Message, aggView2097067683924502974 where Person_likes_Message.MessageId=aggView2097067683924502974.v1;
select SUM(annot) as v9 from aggJoin1240557801234773925;
