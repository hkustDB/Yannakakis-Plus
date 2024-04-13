create or replace view aggView1085216939832237718 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin7476255276429121249 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView1085216939832237718 where mi_idx.movie_id=aggView1085216939832237718.v15;
create or replace view aggView4762899627633563272 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin3506620169947573735 as select v15, v28, v29 from aggJoin7476255276429121249 join aggView4762899627633563272 using(v3);
create or replace view aggView7478316048605785519 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin3506620169947573735 group by v15,v28,v29;
create or replace view aggJoin4713968997045212050 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView7478316048605785519 where mc.movie_id=aggView7478316048605785519.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5022518805587122798 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4143014406611371182 as select v9, v28, v29 from aggJoin4713968997045212050 join aggView5022518805587122798 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4143014406611371182;
