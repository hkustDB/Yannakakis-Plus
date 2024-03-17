create or replace view aggView3424676409831329652 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin260990319345759076 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3424676409831329652 where mc.company_type_id=aggView3424676409831329652.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView9036076466153425068 as select v15, MIN(v9) as v27 from aggJoin260990319345759076 group by v15;
create or replace view aggJoin5616723621935745647 as select movie_id as v15, info_type_id as v3, v27 from movie_info_idx as mi_idx, aggView9036076466153425068 where mi_idx.movie_id=aggView9036076466153425068.v15;
create or replace view aggView7380342430242912876 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin3661632094254281526 as select v15, v27 from aggJoin5616723621935745647 join aggView7380342430242912876 using(v3);
create or replace view aggView1368397654493350638 as select v15, MIN(v27) as v27 from aggJoin3661632094254281526 group by v15;
create or replace view aggJoin8457676037877067328 as select title as v16, production_year as v19, v27 from title as t, aggView1368397654493350638 where t.id=aggView1368397654493350638.v15 and production_year>2010;
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin8457676037877067328;
