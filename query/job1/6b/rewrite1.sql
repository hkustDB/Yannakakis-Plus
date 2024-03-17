create or replace view aggView695925250852742843 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3239378115649387591 as select movie_id as v23, v35 from movie_keyword as mk, aggView695925250852742843 where mk.keyword_id=aggView695925250852742843.v8;
create or replace view aggView3880812565537286762 as select v23, MIN(v35) as v35 from aggJoin3239378115649387591 group by v23;
create or replace view aggJoin1618145389171838585 as select id as v23, title as v24, v35 from title as t, aggView3880812565537286762 where t.id=aggView3880812565537286762.v23 and production_year>2014;
create or replace view aggView5959128760598556001 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin1618145389171838585 group by v23;
create or replace view aggJoin3314694673734917155 as select person_id as v14, v35, v37 from cast_info as ci, aggView5959128760598556001 where ci.movie_id=aggView5959128760598556001.v23;
create or replace view aggView2360135828325626402 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin3314694673734917155 group by v14;
create or replace view aggJoin363933419274890889 as select name as v15, v35, v37 from name as n, aggView2360135828325626402 where n.id=aggView2360135828325626402.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin363933419274890889;
