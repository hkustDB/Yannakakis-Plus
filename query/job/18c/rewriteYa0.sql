create or replace view semiUp2919442044564629337 as select movie_id as v31, info_type_id as v10, info as v20 from movie_info_idx AS mi_idx where (info_type_id) in (select id from info_type AS it2 where info= 'votes');
create or replace view semiUp7420660520619594052 as select movie_id as v31, info_type_id as v8, info as v15 from movie_info AS mi where (movie_id) in (select v31 from semiUp2919442044564629337) and info IN ('Horror','Action','Sci-Fi','Thriller','Crime','War');
create or replace view semiUp4753541919265423799 as select v31, v8, v15 from semiUp7420660520619594052 where (v8) in (select id from info_type AS it1 where info= 'genres');
create or replace view semiUp3506901132383293514 as select id as v31, title as v32 from title AS t where (id) in (select v31 from semiUp4753541919265423799);
create or replace view semiUp1163508600147995239 as select person_id as v22, movie_id as v31 from cast_info AS ci where (movie_id) in (select v31 from semiUp3506901132383293514) and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)');
create or replace view semiUp8094671680016388440 as select id as v22 from name AS n where (id) in (select v22 from semiUp1163508600147995239) and gender= 'm';
create or replace view semiDown4176722712590062401 as select v22, v31 from semiUp1163508600147995239 where (v22) in (select v22 from semiUp8094671680016388440);
create or replace view semiDown5632247174387640739 as select v31, v32 from semiUp3506901132383293514 where (v31) in (select v31 from semiDown4176722712590062401);
create or replace view semiDown4729030395287235047 as select v31, v8, v15 from semiUp4753541919265423799 where (v31) in (select v31 from semiDown5632247174387640739);
create or replace view semiDown679755002325522691 as select id as v8 from info_type AS it1 where (id) in (select v8 from semiDown4729030395287235047) and info= 'genres';
create or replace view semiDown7077642240468862530 as select v31, v10, v20 from semiUp2919442044564629337 where (v31) in (select v31 from semiDown4729030395287235047);
create or replace view semiDown3129989856615771201 as select id as v10 from info_type AS it2 where (id) in (select v10 from semiDown7077642240468862530) and info= 'votes';
create or replace view aggView3051285253560717693 as select v10 from semiDown3129989856615771201;
create or replace view aggJoin3319549346271783230 as select v31, v20 from semiDown7077642240468862530 join aggView3051285253560717693 using(v10);
create or replace view aggView49975600683454715 as select v31, MIN(v20) as v44 from aggJoin3319549346271783230 group by v31;
create or replace view aggJoin1971800732958569705 as select v31, v8, v15, v44 from semiDown4729030395287235047 join aggView49975600683454715 using(v31);
create or replace view aggView6523004392387190759 as select v8 from semiDown679755002325522691;
create or replace view aggJoin5172270605175337918 as select v31, v15, v44 from aggJoin1971800732958569705 join aggView6523004392387190759 using(v8);
create or replace view aggView756621309125398181 as select v31, MIN(v44) as v44, MIN(v15) as v43 from aggJoin5172270605175337918 group by v31,v44;
create or replace view aggJoin4949560731541781254 as select v31, v32, v44, v43 from semiDown5632247174387640739 join aggView756621309125398181 using(v31);
create or replace view aggView5200512835931208826 as select v31, MIN(v44) as v44, MIN(v43) as v43, MIN(v32) as v45 from aggJoin4949560731541781254 group by v31,v44,v43;
create or replace view aggJoin2086069478643411361 as select v22, v44, v43, v45 from semiDown4176722712590062401 join aggView5200512835931208826 using(v31);
create or replace view aggView9137842799376826072 as select v22, MIN(v44) as v44, MIN(v43) as v43, MIN(v45) as v45 from aggJoin2086069478643411361 group by v22,v44,v45,v43;
create or replace view aggJoin4877593584832445585 as select v44, v43, v45 from semiUp8094671680016388440 join aggView9137842799376826072 using(v22);
select MIN(v43) as v43, MIN(v44) as v44, MIN(v45) as v45 from aggJoin4877593584832445585;

