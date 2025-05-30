create or replace view aggView4544306498792841672 as select id as v51 from role_type as rt where role= 'actress';
create or replace view aggJoin3322144229679830764 as select person_id as v42, movie_id as v53, person_role_id as v9, note as v20 from cast_info as ci, aggView4544306498792841672 where ci.role_id=aggView4544306498792841672.v51 and note IN ('(voice)','(voice: Japanese version)','(voice) (uncredited)','(voice: English version)');
create or replace view aggView9078588044607679866 as select id as v42, name as v65 from name as n where gender= 'f';
create or replace view aggJoin5861687363194766850 as select v42, v53, v9, v20, v65 from aggJoin3322144229679830764 join aggView9078588044607679866 using(v42);
create or replace view aggView3221536896826458090 as select v53, v42, v9, MIN(v65) as v65 from aggJoin5861687363194766850 group by v53,v42,v9;
create or replace view aggJoin4488646218629364155 as select id as v53, title as v54, production_year as v57, v42, v9, v65 from title as t, aggView3221536896826458090 where t.id=aggView3221536896826458090.v53 and production_year>2000;
create or replace view aggView7436042256789308720 as select v53, v42, v9, MIN(v65) as v65, MIN(v54) as v66 from aggJoin4488646218629364155 group by v53,v42,v9;
create or replace view aggJoin2056835201196704138 as select movie_id as v53, company_id as v23, v42, v9, v65, v66 from movie_companies as mc, aggView7436042256789308720 where mc.movie_id=aggView7436042256789308720.v53;
create or replace view aggView5514458395691034928 as select v23, v42, v53, v9, MIN(v65) as v65, MIN(v66) as v66 from aggJoin2056835201196704138 group by v23,v42,v53,v9;
create or replace view aggJoin4913326061016444628 as select country_code as v25, v42, v53, v9, v65, v66 from company_name as cn, aggView5514458395691034928 where cn.id=aggView5514458395691034928.v23 and country_code= '[us]';
create or replace view aggView5175761842962591291 as select v9, v42, v53, MIN(v65) as v65, MIN(v66) as v66 from aggJoin4913326061016444628 group by v9,v42,v53;
create or replace view aggJoin9164526394280239751 as select id as v9, v42, v53, v65, v66 from char_name as chn, aggView5175761842962591291 where chn.id=aggView5175761842962591291.v9;
create or replace view aggView3560844549699002382 as select v53, v42, MIN(v65) as v65, MIN(v66) as v66 from aggJoin9164526394280239751 group by v53,v42;
create or replace view aggJoin4248083938141815933 as select movie_id as v53, info_type_id as v30, v42, v65, v66 from movie_info as mi, aggView3560844549699002382 where mi.movie_id=aggView3560844549699002382.v53;
create or replace view aggView9219624342116895801 as select id as v30 from info_type as it where info= 'release dates';
create or replace view aggJoin8205501329341977910 as select v53, v42, v65, v66 from aggJoin4248083938141815933 join aggView9219624342116895801 using(v30);
create or replace view aggView4410735765440349609 as select v42, MIN(v65) as v65, MIN(v66) as v66 from aggJoin8205501329341977910 group by v42;
create or replace view aggJoin7828237265896153740 as select person_id as v42, v65, v66 from aka_name as an, aggView4410735765440349609 where an.person_id=aggView4410735765440349609.v42;
select MIN(v65) as v65,MIN(v66) as v66 from aggJoin7828237265896153740;
