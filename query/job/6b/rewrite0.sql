create or replace view aggView5798254045305875279 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7798575653581350551 as select movie_id as v23, v36 from cast_info as ci, aggView5798254045305875279 where ci.person_id=aggView5798254045305875279.v14;
create or replace view aggView1191649934212865357 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin2103688067610737453 as select movie_id as v23, v35 from movie_keyword as mk, aggView1191649934212865357 where mk.keyword_id=aggView1191649934212865357.v8;
create or replace view aggView7004423547656104197 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin4507437051555783854 as select v23, v35, v37 from aggJoin2103688067610737453 join aggView7004423547656104197 using(v23);
create or replace view aggView1552389730709904993 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin4507437051555783854 group by v23;
create or replace view aggJoin3367686743898889316 as select v36 as v36, v35, v37 from aggJoin7798575653581350551 join aggView1552389730709904993 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3367686743898889316;
