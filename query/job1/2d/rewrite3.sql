create or replace view aggView274680018255286634 as select id as v12, title as v31 from title as t;
create or replace view aggJoin2737553450979934160 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView274680018255286634 where mk.movie_id=aggView274680018255286634.v12;
create or replace view aggView1454730220434183221 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin1234872707703402030 as select movie_id as v12 from movie_companies as mc, aggView1454730220434183221 where mc.company_id=aggView1454730220434183221.v1;
create or replace view aggView4442381809255059813 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2363967550435147934 as select v12, v31 from aggJoin2737553450979934160 join aggView4442381809255059813 using(v18);
create or replace view aggView487221567333576251 as select v12, MIN(v31) as v31 from aggJoin2363967550435147934 group by v12;
create or replace view aggJoin1773118561817508508 as select v31 from aggJoin1234872707703402030 join aggView487221567333576251 using(v12);
select MIN(v31) as v31 from aggJoin1773118561817508508;
