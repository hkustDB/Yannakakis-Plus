create or replace view aggView1264595565914567000 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1248385465002544036 as select movie_id as v23, v36 from cast_info as ci, aggView1264595565914567000 where ci.person_id=aggView1264595565914567000.v14;
create or replace view aggView8789608176857156206 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3774380178556551820 as select movie_id as v23, v35 from movie_keyword as mk, aggView8789608176857156206 where mk.keyword_id=aggView8789608176857156206.v8;
create or replace view aggView525794453417792519 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin286723693177323045 as select v23, v35, v37 from aggJoin3774380178556551820 join aggView525794453417792519 using(v23);
create or replace view aggView3009354750735364670 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin286723693177323045 group by v23;
create or replace view aggJoin8349737415518493999 as select v36 as v36, v35, v37 from aggJoin1248385465002544036 join aggView3009354750735364670 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8349737415518493999;
