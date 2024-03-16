create or replace view aggView2905941289641575190 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin3482560110602752860 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView2905941289641575190 where mc.movie_id=aggView2905941289641575190.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView3129177088086073616 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7667129452249599198 as select v15, v9, v27 from aggJoin3482560110602752860 join aggView3129177088086073616 using(v1);
create or replace view aggView5768944493135382226 as select v15, MIN(v27) as v27 from aggJoin7667129452249599198 group by v15;
create or replace view aggJoin734048683190183715 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView5768944493135382226 where mi.movie_id=aggView5768944493135382226.v15 and info IN ('USA','America');
create or replace view aggView8540005594783191503 as select v3, MIN(v27) as v27 from aggJoin734048683190183715 group by v3;
create or replace view aggJoin1909779452624515568 as select v27 from info_type as it, aggView8540005594783191503 where it.id=aggView8540005594783191503.v3;
select MIN(v27) as v27 from aggJoin1909779452624515568;
