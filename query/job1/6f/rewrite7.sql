create or replace view aggView7740739142586201463 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin5561926474103273565 as select movie_id as v23, v35 from movie_keyword as mk, aggView7740739142586201463 where mk.keyword_id=aggView7740739142586201463.v8;
create or replace view aggView6578066450336334389 as select id as v14, name as v36 from name as n;
create or replace view aggJoin3136747040929235268 as select movie_id as v23, v36 from cast_info as ci, aggView6578066450336334389 where ci.person_id=aggView6578066450336334389.v14;
create or replace view aggView9187359717282222071 as select v23, MIN(v36) as v36 from aggJoin3136747040929235268 group by v23;
create or replace view aggJoin4535590383198774057 as select id as v23, title as v24, v36 from title as t, aggView9187359717282222071 where t.id=aggView9187359717282222071.v23 and production_year>2000;
create or replace view aggView3140775676709933270 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin4535590383198774057 group by v23;
create or replace view aggJoin1973288400440155719 as select v35 as v35, v36, v37 from aggJoin5561926474103273565 join aggView3140775676709933270 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1973288400440155719;
