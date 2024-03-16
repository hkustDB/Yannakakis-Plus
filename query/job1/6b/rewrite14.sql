create or replace view aggView5061156521832397794 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin5032482644809077025 as select movie_id as v23, v35 from movie_keyword as mk, aggView5061156521832397794 where mk.keyword_id=aggView5061156521832397794.v8;
create or replace view aggView3187009178314113700 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin6933740136482998401 as select v23, v35 from aggJoin5032482644809077025 join aggView3187009178314113700 using(v23);
create or replace view aggView4638992144828710712 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin1572410008769223978 as select movie_id as v23, v36 from cast_info as ci, aggView4638992144828710712 where ci.person_id=aggView4638992144828710712.v14;
create or replace view aggView2810767969696614721 as select v23, MIN(v36) as v36 from aggJoin1572410008769223978 group by v23;
create or replace view aggJoin6262884212251935849 as select v35 as v35, v36 from aggJoin6933740136482998401 join aggView2810767969696614721 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6262884212251935849;
