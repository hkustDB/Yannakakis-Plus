create or replace view aggView2135024294655435418 as select id as v12, title as v31 from title as t;
create or replace view aggJoin3357076551237663632 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView2135024294655435418 where mk.movie_id=aggView2135024294655435418.v12;
create or replace view aggView3220512248317236593 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin716900873961870010 as select movie_id as v12 from movie_companies as mc, aggView3220512248317236593 where mc.company_id=aggView3220512248317236593.v1;
create or replace view aggView2675816366225426380 as select v12 from aggJoin716900873961870010 group by v12;
create or replace view aggJoin1997691577410235642 as select v18, v31 as v31 from aggJoin3357076551237663632 join aggView2675816366225426380 using(v12);
create or replace view aggView1787284413843376475 as select v18, MIN(v31) as v31 from aggJoin1997691577410235642 group by v18;
create or replace view aggJoin6326333292054656764 as select keyword as v9, v31 from keyword as k, aggView1787284413843376475 where k.id=aggView1787284413843376475.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin6326333292054656764;
