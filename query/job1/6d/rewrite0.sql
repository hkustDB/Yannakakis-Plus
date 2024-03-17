create or replace view aggView2266391213157492469 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin5261151879955878975 as select movie_id as v23, v35 from movie_keyword as mk, aggView2266391213157492469 where mk.keyword_id=aggView2266391213157492469.v8;
create or replace view aggView2238293702751060398 as select v23, MIN(v35) as v35 from aggJoin5261151879955878975 group by v23;
create or replace view aggJoin924028421801823064 as select id as v23, title as v24, v35 from title as t, aggView2238293702751060398 where t.id=aggView2238293702751060398.v23 and production_year>2000;
create or replace view aggView922288399333878982 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin924028421801823064 group by v23;
create or replace view aggJoin4166106663647153613 as select person_id as v14, v35, v37 from cast_info as ci, aggView922288399333878982 where ci.movie_id=aggView922288399333878982.v23;
create or replace view aggView1635851184442607676 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin4166106663647153613 group by v14;
create or replace view aggJoin4303496826624540554 as select name as v15, v35, v37 from name as n, aggView1635851184442607676 where n.id=aggView1635851184442607676.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin4303496826624540554;
