create or replace view aggView6745180758189170435 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5409208481163355294 as select movie_id as v23, v36 from cast_info as ci, aggView6745180758189170435 where ci.person_id=aggView6745180758189170435.v14;
create or replace view aggView4337179105021267955 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin6237218524400869786 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView4337179105021267955 where mk.movie_id=aggView4337179105021267955.v23;
create or replace view aggView6493927498794967057 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin9208465047441221171 as select v23, v37 from aggJoin6237218524400869786 join aggView6493927498794967057 using(v8);
create or replace view aggView2380495861073738471 as select v23, MIN(v37) as v37 from aggJoin9208465047441221171 group by v23;
create or replace view aggJoin4486577943194553377 as select v36 as v36, v37 from aggJoin5409208481163355294 join aggView2380495861073738471 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4486577943194553377;
