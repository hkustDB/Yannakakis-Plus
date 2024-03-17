create or replace view aggView2913517483284220770 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin6093276852837726426 as select movie_id as v15 from movie_info_idx as mi_idx, aggView2913517483284220770 where mi_idx.info_type_id=aggView2913517483284220770.v3;
create or replace view aggView5582395956923263012 as select v15 from aggJoin6093276852837726426 group by v15;
create or replace view aggJoin2346620321857605352 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView5582395956923263012 where mc.movie_id=aggView5582395956923263012.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView1501423576077130262 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin691509630762806782 as select v15, v9 from aggJoin2346620321857605352 join aggView1501423576077130262 using(v1);
create or replace view aggView1736367213678362348 as select v15, MIN(v9) as v27 from aggJoin691509630762806782 group by v15;
create or replace view aggJoin5891811105363606070 as select title as v16, production_year as v19, v27 from title as t, aggView1736367213678362348 where t.id=aggView1736367213678362348.v15;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin5891811105363606070;
