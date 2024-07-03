create or replace view aggView5503343584688051401 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin5106185197673992969 as select movie_id as v23, v35 from movie_keyword as mk, aggView5503343584688051401 where mk.keyword_id=aggView5503343584688051401.v8;
create or replace view aggView452000553570143973 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin252913223428260592 as select v23, v35, v37 from aggJoin5106185197673992969 join aggView452000553570143973 using(v23);
create or replace view aggView4909892681223440125 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin252913223428260592 group by v23,v37,v35;
create or replace view aggJoin946075709112293175 as select person_id as v14, v35, v37 from cast_info as ci, aggView4909892681223440125 where ci.movie_id=aggView4909892681223440125.v23;
create or replace view aggView5092440427805457873 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin946075709112293175 group by v14,v37,v35;
create or replace view aggJoin4937070552017430300 as select name as v15, v35, v37 from name as n, aggView5092440427805457873 where n.id=aggView5092440427805457873.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin4937070552017430300;
