create or replace view aggView6859730700430572644 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin3252235345584019755 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6859730700430572644 where Message_hasCreator_Person.MessageId=aggView6859730700430572644.v1;
create or replace view aggView7651311392352114783 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin2892924971267361735 as select v1, aggJoin3252235345584019755.annot * aggView7651311392352114783.annot as annot from aggJoin3252235345584019755 join aggView7651311392352114783 using(v1);
create or replace view aggView6480891742225575354 as select v1, SUM(annot) as annot from aggJoin2892924971267361735 group by v1;
create or replace view aggJoin5774271715137170744 as select annot from Person_likes_Message as Person_likes_Message, aggView6480891742225575354 where Person_likes_Message.MessageId=aggView6480891742225575354.v1;
select SUM(annot) as v9 from aggJoin5774271715137170744;
