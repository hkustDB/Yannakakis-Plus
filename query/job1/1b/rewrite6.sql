create or replace view aggView2765339605612740190 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin2135087777337363623 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView2765339605612740190 where mc.movie_id=aggView2765339605612740190.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3302764425355253113 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin7699070200340405763 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3302764425355253113 where mi_idx.info_type_id=aggView3302764425355253113.v3;
create or replace view aggView54123292669095441 as select v15 from aggJoin7699070200340405763 group by v15;
create or replace view aggJoin7955325695824337738 as select v1, v9, v28 as v28, v29 as v29 from aggJoin2135087777337363623 join aggView54123292669095441 using(v15);
create or replace view aggView1264451424527480556 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin760823144974295971 as select v9, v28, v29 from aggJoin7955325695824337738 join aggView1264451424527480556 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin760823144974295971;
