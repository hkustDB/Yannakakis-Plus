create or replace view aggView7870250508004765126 as select id as v12, title as v31 from title as t;
create or replace view aggJoin1224148551773520354 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView7870250508004765126 where mk.movie_id=aggView7870250508004765126.v12;
create or replace view aggView2967203528540175931 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin4437138808732217193 as select movie_id as v12 from movie_companies as mc, aggView2967203528540175931 where mc.company_id=aggView2967203528540175931.v1;
create or replace view aggView4065949498535184247 as select v12 from aggJoin4437138808732217193 group by v12;
create or replace view aggJoin2116132224455136530 as select v18, v31 as v31 from aggJoin1224148551773520354 join aggView4065949498535184247 using(v12);
create or replace view aggView4656952335973573186 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3830878265721726631 as select v31 from aggJoin2116132224455136530 join aggView4656952335973573186 using(v18);
select MIN(v31) as v31 from aggJoin3830878265721726631;
