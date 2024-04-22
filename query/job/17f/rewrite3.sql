create or replace view aggJoin8536471595780342504 as (
with aggView8135696757387266973 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView8135696757387266973 where mk.keyword_id=aggView8135696757387266973.v25);
create or replace view aggJoin890986313093818869 as (
with aggView2417130576652491665 as (select v3 from aggJoin8536471595780342504 group by v3)
select id as v3 from title as t, aggView2417130576652491665 where t.id=aggView2417130576652491665.v3);
create or replace view aggJoin7418183122833961758 as (
with aggView6916265616190904807 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView6916265616190904807 where mc.company_id=aggView6916265616190904807.v20);
create or replace view aggJoin7435587093686723639 as (
with aggView391238639804807827 as (select v3 from aggJoin7418183122833961758 group by v3)
select v3 from aggJoin890986313093818869 join aggView391238639804807827 using(v3));
create or replace view aggJoin752145043852835485 as (
with aggView8619419560357396323 as (select v3 from aggJoin7435587093686723639 group by v3)
select person_id as v26 from cast_info as ci, aggView8619419560357396323 where ci.movie_id=aggView8619419560357396323.v3);
create or replace view aggJoin475558019209912425 as (
with aggView4005783207766256194 as (select v26 from aggJoin752145043852835485 group by v26)
select name as v27 from name as n, aggView4005783207766256194 where n.id=aggView4005783207766256194.v26 and name LIKE '%B%');
create or replace view aggView7413640543658671501 as select v27 from aggJoin475558019209912425 group by v27;
select MIN(v27) as v47 from aggView7413640543658671501;
