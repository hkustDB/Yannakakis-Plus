create or replace view aggView6634585731538224163 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin6355163555994868313 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6634585731538224163 where mc.movie_id=aggView6634585731538224163.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView4188711190452488604 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin3771666898055060704 as select movie_id as v15 from movie_info_idx as mi_idx, aggView4188711190452488604 where mi_idx.info_type_id=aggView4188711190452488604.v3;
create or replace view aggView3381978434614493135 as select v15 from aggJoin3771666898055060704 group by v15;
create or replace view aggJoin3776905525793020203 as select v1, v9, v28 as v28, v29 as v29 from aggJoin6355163555994868313 join aggView3381978434614493135 using(v15);
create or replace view aggView7184562540791968714 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3097353475327743847 as select v9, v28, v29 from aggJoin3776905525793020203 join aggView7184562540791968714 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3097353475327743847;
