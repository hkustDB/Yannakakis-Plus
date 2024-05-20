create or replace view aggView6536000243395065937 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin9021806758676075364 as select movie_id as v23, v35 from movie_keyword as mk, aggView6536000243395065937 where mk.keyword_id=aggView6536000243395065937.v8;
create or replace view aggView6897823845127539488 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin5946188640558286190 as select v23, v35, v37 from aggJoin9021806758676075364 join aggView6897823845127539488 using(v23);
create or replace view aggView775552937609247146 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin5946188640558286190 group by v23;
create or replace view aggJoin3617379875068958044 as select person_id as v14, v35, v37 from cast_info as ci, aggView775552937609247146 where ci.movie_id=aggView775552937609247146.v23;
create or replace view aggView4950091320310680309 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin3617379875068958044 group by v14;
create or replace view aggJoin627189005755328227 as select name as v15, v35, v37 from name as n, aggView4950091320310680309 where n.id=aggView4950091320310680309.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin627189005755328227;
