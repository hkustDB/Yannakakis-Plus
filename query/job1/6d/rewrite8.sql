create or replace view aggView435102656778138837 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1247589731033965401 as select movie_id as v23, v36 from cast_info as ci, aggView435102656778138837 where ci.person_id=aggView435102656778138837.v14;
create or replace view aggView697627859296291305 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3067135880272366001 as select movie_id as v23, v35 from movie_keyword as mk, aggView697627859296291305 where mk.keyword_id=aggView697627859296291305.v8;
create or replace view aggView5946732162243411119 as select v23, MIN(v35) as v35 from aggJoin3067135880272366001 group by v23;
create or replace view aggJoin4562509016097009859 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView5946732162243411119 where t.id=aggView5946732162243411119.v23 and production_year>2000;
create or replace view aggView7295036954529455742 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin4562509016097009859 group by v23;
create or replace view aggJoin3026710520852729868 as select v36 as v36, v35, v37 from aggJoin1247589731033965401 join aggView7295036954529455742 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3026710520852729868;
