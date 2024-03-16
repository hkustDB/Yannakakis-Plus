create or replace view aggView247851353300267242 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin5837349197751956677 as select movie_id as v12 from movie_companies as mc, aggView247851353300267242 where mc.company_id=aggView247851353300267242.v1;
create or replace view aggView4009677053372262102 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3145211620556212504 as select movie_id as v12 from movie_keyword as mk, aggView4009677053372262102 where mk.keyword_id=aggView4009677053372262102.v18;
create or replace view aggView1986890412477782574 as select v12 from aggJoin3145211620556212504 group by v12;
create or replace view aggJoin1933905425977889329 as select v12 from aggJoin5837349197751956677 join aggView1986890412477782574 using(v12);
create or replace view aggView785160097925359294 as select v12 from aggJoin1933905425977889329 group by v12;
create or replace view aggJoin1404250009232202333 as select title as v20 from title as t, aggView785160097925359294 where t.id=aggView785160097925359294.v12;
select MIN(v20) as v31 from aggJoin1404250009232202333;
