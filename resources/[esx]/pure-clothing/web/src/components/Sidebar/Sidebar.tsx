import React, { useEffect } from 'react';
import { useAppDistpatch, useAppSelector } from '../../store/store';
import { popupPage, togglePopup } from '../../store/features/popup/popupSlice';
import sidebarItems from '../../menus/sidebarItems';
import updateRipples from '../../utils/updateRipple';
import { setCurrentClothingPage } from '../../store/features/pages/currentClothingPageSlice';
import { setCurrentCreateCharPage } from '../../store/features/pages/currentCreateCharPageSlice';
import './Sidebar.scss';
import { sendNui } from '../../utils/sendNui';
import { setActiveDiv } from '../../store/features/pages/currentPageSlice';

const Sidebar: React.FC = () => {
  // const [activeDiv, setActiveDiv] = useState(0);
  const dispatch = useAppDistpatch();
  const theme = useAppSelector((state: any) => state.theme.theme);
  const config = useAppSelector((state: any) => state.config.config);
  const disabledMenuForPeds = useAppSelector(
    (state: any) => state.config.disabledMenusForPed
  );
  const currentPage: any = useAppSelector(
    (state: any) => state.currentPage.currentPage
  );

  const activeDiv = useAppSelector((state: any) => state.currentPage.activeDiv);

  // setActiveDiv(0);

  const switchIcons = (index: number, name: string, menu: string) => {
    // setActiveDiv(index);
    dispatch(setActiveDiv(index));
    switch (name) {
      case 'clothing':
        dispatch(setCurrentClothingPage(menu));
        break;
      case 'createCharacter':
        dispatch(setCurrentCreateCharPage(menu));
        break;
      default:
        break;
    }
  };

  const handleButton = (name: string) => {
    // console.log(name, 'name');
    if (
      (!config.saveDeletePopup && name === 'save') ||
      (!config.saveDeletePopup && name === 'delete')
    ) {
      // console.log('save or delete - disabled in config');
      if (name === 'save') {
        sendNui('saveButton', {
          payment: config.defaultPayment,
          currentPage: currentPage,
        });
        return;
      }
      if (name === 'delete') {
        sendNui('deleteButton', {
          currentPage: currentPage,
        });
        return;
      }
      return;
    }
    dispatch(togglePopup(true));
    dispatch(popupPage(name));
  };

  useEffect(() => {
    updateRipples();
  }, [currentPage]);

  const currentSidebarItems: any = sidebarItems;
  const sidebarItemsList: any = currentSidebarItems[currentPage];

  const currentCharacterCharPage = useAppSelector(
    (state) => state.currentCreateCharPage.currentPage
  );

  return (
    <>
      <div
        className={`sidebar ${
          config.nui['position'] === 'left' ? 'sidebar-left' : 'sidebar-right'
        }`}
        style={{
          position: 'fixed',
          backgroundColor: theme.background['sidebar'],
        }}
      >
        <div className="divider">
          <section>
            {sidebarItemsList.map((item: any, index: number) => {
              let show = true;
              if (
                currentPage === 'hair' ||
                currentPage === 'tattoo' ||
                currentPage === 'outfits'
              ) {
                show = config.nui['menus'][currentPage];
              } else {
                show = config.nui['menus'][currentPage][item.name];
              }
              if (
                item.name === 'faceStructure' &&
                disabledMenuForPeds &&
                config.nui.whenPedDisableUneededMenus
              ) {
                show = false;
              }
              if (!show) {
                return null;
              }
              const svgElement = React.createElement(
                'svg',
                {
                  viewBox: item.icon.viewBox,
                  fill: 'currentColor',
                  height: '1em',
                  width: '1em',
                  style: {
                    color: theme.text['white'],
                    marginLeft: index === activeDiv ? '0.2rem' : '0',
                  },
                },
                React.createElement('path', {
                  d: item.icon.d,
                })
              );
              return (
                <div
                  key={index}
                  className={`sidebar__icon ripple-animation`}
                  style={{
                    color: theme.text['white'],
                    backgroundColor:
                      index === activeDiv
                        ? theme.mainColourway['main-colour-faded']
                        : null,
                    borderRight:
                      index === activeDiv
                        ? theme.sidebar['onSelectBorder'] +
                          ' ' +
                          theme.mainColourway['main-colour']
                        : 0,
                  }}
                  onClick={() => {
                    switchIcons(index, currentPage, item.name);
                  }}
                >
                  {svgElement}
                </div>
              );
            })}
          </section>
          <section>
            {currentPage === 'tattoo' && (
              <div
                className="bottom__icon info ripple-animation"
                onClick={() => handleButton('tattooClear')}
                style={{
                  color: theme.text['white'],
                  backgroundColor: theme.sidebar['tattooClear'],
                }}
              >
                <svg
                  viewBox="0 0 961.375 1000"
                  fill="currentColor"
                  height="1em"
                  width="1em"
                >
                  <path d="M118 680c25.333-22.667 53.667-32.333 85-29 31.333 3.333 60.333 18.333 87 45 28 26.667 44 55.667 48 87s-6 59-30 83c-57.333 56-133.333 90-228 102-56 8-82.667 3.333-80-14 0-2.667 2-6 6-10 34.667-40 56-88.333 64-145s24-96.333 48-119M958 34c17.333 17.333-32 100-148 248S596.667 542.667 518 620c-25.333 25.333-66.667 60-124 104-5.333 4-10.667 1.333-16-8-12-22.667-28-44-48-64-21.333-21.333-43.333-37.333-66-48-10.667-4-13.333-9.333-8-16 42.667-56 77.333-96.667 104-122 78.667-77.333 193.333-173 344-287S939.333 16.667 958 34" />
                </svg>
              </div>
            )}
            {currentCharacterCharPage === 'tattoos' && (
              <div
                className="bottom__icon info ripple-animation"
                onClick={() => handleButton('tattooClear')}
                style={{
                  color: theme.text['white'],
                  backgroundColor: theme.sidebar['tattooClear'],
                }}
              >
                <svg
                  viewBox="0 0 961.375 1000"
                  fill="currentColor"
                  height="1em"
                  width="1em"
                >
                  <path d="M118 680c25.333-22.667 53.667-32.333 85-29 31.333 3.333 60.333 18.333 87 45 28 26.667 44 55.667 48 87s-6 59-30 83c-57.333 56-133.333 90-228 102-56 8-82.667 3.333-80-14 0-2.667 2-6 6-10 34.667-40 56-88.333 64-145s24-96.333 48-119M958 34c17.333 17.333-32 100-148 248S596.667 542.667 518 620c-25.333 25.333-66.667 60-124 104-5.333 4-10.667 1.333-16-8-12-22.667-28-44-48-64-21.333-21.333-43.333-37.333-66-48-10.667-4-13.333-9.333-8-16 42.667-56 77.333-96.667 104-122 78.667-77.333 193.333-173 344-287S939.333 16.667 958 34" />
                </svg>
              </div>
            )}
            {currentCharacterCharPage === 'faceStructure' &&
              currentPage === 'createCharacter' &&
              config.randomiser.enabled && (
                <div
                  className="bottom__icon info ripple-animation"
                  onClick={() => handleButton('randomiser')}
                  style={{
                    color: theme.text['white'],
                    backgroundColor: theme.sidebar['randomiser'],
                  }}
                >
                  <svg
                    viewBox="0 0 512 512"
                    fill="currentColor"
                    height="1em"
                    width="1em"
                  >
                    <path d="M403.8 34.4c12-5 25.7-2.2 34.9 6.9l64 64c6 6 9.4 14.1 9.4 22.6s-3.4 16.6-9.4 22.6l-64 64c-9.2 9.2-22.9 11.9-34.9 6.9S384 204.8 384 191.8V160h-32c-10.1 0-19.6 4.7-25.6 12.8L284 229.3 244 176l31.2-41.6C293.3 110.2 321.8 96 352 96h32V64c0-12.9 7.8-24.6 19.8-29.6zM164 282.7l40 53.3-31.2 41.6C154.7 401.8 126.2 416 96 416H32c-17.7 0-32-14.3-32-32s14.3-32 32-32h64c10.1 0 19.6-4.7 25.6-12.8l42.4-56.5zm274.6 188c-9.2 9.2-22.9 11.9-34.9 6.9S383.9 461 383.9 448v-32H352c-30.2 0-58.7-14.2-76.8-38.4L121.6 172.8c-6-8.1-15.5-12.8-25.6-12.8H32c-17.7 0-32-14.3-32-32s14.3-32 32-32h64c30.2 0 58.7 14.2 76.8 38.4l153.6 204.8c6 8.1 15.5 12.8 25.6 12.8h32v-32c0-12.9 7.8-24.6 19.8-29.6s25.7-2.2 34.9 6.9l64 64c6 6 9.4 14.1 9.4 22.6s-3.4 16.6-9.4 22.6l-64 64z" />
                  </svg>
                </div>
              )}
            <div
              className="bottom__icon info ripple-animation"
              onClick={() => handleButton('info')}
              style={{
                color: theme.text['white'],
                backgroundColor: theme.sidebar['info'],
              }}
            >
              <svg
                viewBox="0 0 1024 1024"
                fill="currentColor"
                height="1em"
                width="1em"
              >
                <path d="M512 64C264.6 64 64 264.6 64 512s200.6 448 448 448 448-200.6 448-448S759.4 64 512 64zm32 664c0 4.4-3.6 8-8 8h-48c-4.4 0-8-3.6-8-8V456c0-4.4 3.6-8 8-8h48c4.4 0 8 3.6 8 8v272zm-32-344a48.01 48.01 0 010-96 48.01 48.01 0 010 96z" />
              </svg>
            </div>
            <div
              className="bottom__icon delete ripple-animation"
              onClick={() => handleButton('delete')}
              style={{
                color: theme.text['white'],
                backgroundColor: theme.sidebar['delete'],
              }}
            >
              {' '}
              <svg
                viewBox="0 0 24 24"
                fill="currentColor"
                height="1em"
                width="1em"
              >
                <path d="M19 4h-3.5l-1-1h-5l-1 1H5v2h14M6 19a2 2 0 002 2h8a2 2 0 002-2V7H6v12z" />
              </svg>
            </div>
            <div
              className="bottom__icon save ripple-animation"
              onClick={() => handleButton('save')}
              style={{
                color: theme.text['white'],
                backgroundColor: theme.sidebar['save'],
              }}
            >
              {' '}
              <svg
                viewBox="0 0 512 512"
                fill="currentColor"
                height="1em"
                width="1em"
              >
                <path d="M380.44 32H64a32 32 0 00-32 32v384a32 32 0 0032 32h384a32.09 32.09 0 0032-32V131.56zM112 176v-64h192v64zm223.91 179.76a80 80 0 11-83.66-83.67 80.21 80.21 0 0183.66 83.67z" />
              </svg>
            </div>
          </section>
        </div>
      </div>
    </>
  );
};

export default Sidebar;
